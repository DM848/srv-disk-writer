include "console.iol"
include "srv-disk-writer.iol"


execution {sequential}  //concurrnet?

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
        println@Console("I should write to file: \n\n" + request.program)();
        
        
        //write user program to google cloud persistant storage
        writeFile@File({.content = request.content, .filename = "/data/" + request.filename})();
        
        response = "finished"
    }]
    
    [getProgram(token)(response){
        println@Console("Fetching program for user service: " + token)();
        readFile@File( { .filename = "/data/" + token + ".ol" } )( response )
        }]
        
    [deleteProgram(token)(answer){
        println@Console("Deleting file: " + )();
        delete@File("/data/" + token + ".ol")();
        answer = "deleted file"
        }]
}