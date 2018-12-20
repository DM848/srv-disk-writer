include "srv-disk-writer.iol"
include "console.iol"

outputPort DiskWriter{
    Location: "socket://localhost:8020/"
    Protocol: http
    Interfaces: DiskWriterInterface
}

main
{

    writeProgram@DiskWriter({.content = "request.program", .filename = "asdf.ol"})(resp);
    println@Console(resp)();
    
    haveProgram@DiskWriter()(resp);
    println@Console(resp)()
}