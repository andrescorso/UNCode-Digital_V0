#!/usr/bin/env python
# coding: utf-8
import sys
from Verilog_VCD.Verilog_VCD import parse_vcd
import Verilog_VCD as vvcd
import json
file_name = sys.argv[1]
vcd = parse_vcd(file_name+'.vcd')
ts = vvcd.Verilog_VCD.get_timescale()
ts = int(''.join(filter(str.isdigit, ts)))
et = vvcd.Verilog_VCD.get_endtime()



def readGolden(golden):
    Gwaves = {}
    Gdata = {}
    for i in golden["signal"]:
        Gwaves[i["name"]] = i["wave"]
        if i.get("data",None) != None:
            Gdata[i["name"]] = i["data"]

    return Gwaves,Gdata

goldenF = True if sys.argv[2] == "comp" else False
Gwaves = {}
Gdata = {}
if goldenF:
    try:
     json_file =  open('code/golden.wf')
     golden = eval(json_file.read())
     Gwaves,Gdata = readGolden(golden)
    except:
     goldenF = False



wavedrom = "{ \"signal\": [\n"
signals = []
bfl = 65
fl = bfl
def gfl():
    global fl
    fl += 1
    return chr(fl-1)


for i in vcd.keys():
    names = []
    for j in vcd[i]["nets"]:
        name_dut = j["hier"].split(".")
        if len(name_dut) > 1:
            if name_dut[1] == "dut":
                names.append((j["name"],j["size"],j["type"]))
    strsignals = ""
    for signal in names:
        name = signal[0]
        allt = vcd[i]["tv"]
        wave = ""
        utime = 0 
        bit = False
        stop= False
        data = []
        node = ""
        if signal[1] == "1": bit = True
        idxG = 0
        idxD = 0
        difBus = False
        for t in range(0,int(et)+2*int(ts),10000000*int(ts)):
            cW = ""
            if not(stop) and t >= allt[utime][0]:
                if bit: 
                    wave += allt[utime][1]
                    cW = allt[utime][1]
                else:
                    cW = hex(int(allt[utime][1], 2))[2:].upper()
                    data.append(cW)
                    if goldenF and cW != Gdata[name][idxD]:
                        wave += "9"
                        difBus = True
                    else:
                        wave += "2"
                    idxD += 1
                utime += 1
                if utime == len(allt): 
                    stop = True
            else:
                wave +="."
                cW = "."
            
            if (goldenF and Gwaves[name][idxG] != "2" and cW != Gwaves[name][idxG]):
                node += gfl()
            else:
                node+="."
            idxG += 1
        strsignals += "{\"name\": '"+name+"', \"wave\": '"+wave+"'"
        if len(data) > 0:
            strsignals += ", \"data\":"
            strsignals += "["
            strsignals += ', '.join("'{0}'".format(w) for w in data)
            strsignals += "]"
        realsignal = ""
        if len(node) != node.count("."):
            strsignals += ", \"node\":"
            strsignals += "'"
            strsignals += node
            strsignals += "'"
        if len(node) != node.count(".") or difBus: 
            realsignal = "{\"name\": '"+name+"*', \"wave\": '"+Gwaves[name]+"'"
            if Gdata.get(name,None) != None:
                realsignal += ", \"data\":"
                realsignal += "["
                realsignal += ', '.join("'{0}'".format(w) for w in Gdata[name])
                realsignal += "]"
            realsignal +="}"
        strsignals += "}"
        signals.append(strsignals)
        if realsignal != "":
            signals.append(realsignal)



wavedrom += ", \n".join(signals)
wavedrom += "]\n"
if bfl != fl:
    wavedrom += ",\"edge\":[\n"
    edges = []
    for cfl in range(bfl,fl,2):
        edges.append("'"+chr(cfl)+"|-|"+chr(cfl+1)+" diff'")
    wavedrom += ", ".join(edges)
    wavedrom += "]"
wavedrom += "}"
print(wavedrom)        
if goldenF:
    fi = open(f"code/waveform.wf",'w')
    fi.write(wavedrom)
    fi.close()
else:
    fi = open(f"code/golden.wf",'w')
    fi.write(wavedrom)
    fi.close()




