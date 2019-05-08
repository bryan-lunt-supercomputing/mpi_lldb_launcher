import os
import lldb
import sys

urls = sys.argv[1:]

#
#Lots of code taken from:
#
#https://opensource.apple.com/source/lldb/lldb-159/www/python-reference.html
#


# Create a new debugger instance
debugger = lldb.SBDebugger.Create()
#debugger.SetAsync(False)
set_plat_error = debugger.SetCurrentPlatform("remote-linux")
assert(False == set_plat_error.Fail())

print(debugger.GetSelectedPlatform().GetName())

#curr_plat = debugger.GetSelectedPlatform()
curr_plat = lldb.SBPlatform("remote-linux")
print("Plat valid? {}".format(curr_plat.IsValid()))

connection_params = lldb.SBPlatformConnectOptions("connect://{}".format(urls[0]))
con_error = curr_plat.ConnectRemote(connection_params)
print("Connection successs? {}".format(con_error.Success()))

print("Platform connected? {} Still Valid? {}".format(curr_plat.IsConnected(), curr_plat.IsValid()))


target = debugger.CreateTarget('')
target.BreakpointCreateByName("main")
target_error = lldb.SBError()
a_process = target.ConnectRemote(debugger.GetListener(),"connect://{}".format(urls[0]),"remote-linux",target_error)
#a_proc_c_error = a_process.Continue()

#target2 = debugger.CreateTarget('')
#target2_error = lldb.SBError()
#another_process = target2.ConnectRemote(debugger.GetListener(),"connect://{}".format(urls[1]),None,target_error)
