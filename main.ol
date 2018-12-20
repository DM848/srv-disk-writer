include "console.iol"
include "srv-disk-writer.iol"


execution {sequential}

inputPort input{
    Location: "socket://localhost:8020/"
    Protocol: http
    Interfaces: DiskWriterInterface
}


init
{
    println@Console("Initializing disk writer")()
}

main
{
    [writeProgram(request)(response){
        println@Console("I should write to file")();
        
        
        //write user program to google cloud persistant storage
        writeFile@File({.content = request.program, .filename = request.filename})();
        
        response = "finished"
    }]
    
    [getProgram(token)(response){
        response = "i don't know"
        }]
}