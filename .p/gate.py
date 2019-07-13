"""Pyhton Gate server.

"""


import pdb
import sys
import json
import socket, SocketServer


import claripy, angr

e = {}

class PythonGate(SocketServer.StreamRequestHandler):

    def handle_one_packet(self):
        try:
            requestline = self.rfile.readline()
            sys.stdout.write("> %s\n" % requestline)
            answer = self.getAnswer(requestline) + '\r\n'
            self.wfile.write(answer)
            sys.stdout.write("< %s\n" % answer)
            self.wfile.flush()
        except socket.timeout, e:
            os._exit(0)
            return

    def handle(self):
        while True:
            self.handle_one_packet()

    def getAnswer(self, request):
        if request[0]=='.':
            return self.doExec(request[1:])
        else:
            return self.doEval(request);

    def doEval(self, request):
        result = eval(request)
        try:
            return 'J' + json.dumps(result)
        except TypeError:
            return '+' + self.getNonJSON(result)

    def doExec(self, value):
        try:
            exec(value)
            return '+'
        except:
            return '-'

    def getNonJSON(self, value):
        return value.__class__.__name__ + ':' + value.__str__()

SocketServer.TCPServer(('',7000), PythonGate).serve_forever()
