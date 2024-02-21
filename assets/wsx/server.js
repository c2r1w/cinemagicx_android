const wev =require('ws');

const server = new wev.Server({ port: 5000 });

server.on('connection', (socket) => {

    console.log('Client connected');

    socket.on('message', (message) => {

        console.log(`Received message: ${message}`);
        socket.send(`replay${message}`)

    }
    );

    socket.on("close",(rr)=>{

        console.log(`Received message: `);


    })

});