const express = require('express');
const http = require('http');
const fs = require('fs');
const path = require('path');
const WebSocket = require('ws');  
const { spawn} = require('child_process');

const app = express();
const PORT = 3000;
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

let inputCallback = null;
let programProcess;
let extraIp = 0;

wss.on('connection', (ws) => {
  console.log('Client connected');

  ws.on('message', async (message) => {
    try {
      
      const data = JSON.parse(message);
      
      if(data.closeProcess){
        programProcess.kill();
      }  
      if(data.isIpMode){
        inputCallback = (input) => {
          input=input.trim();
          
            const numbersArray = input.split(/\s+/);
            // Count the non-empty elements in the resulting array
            const count = numbersArray.filter(num => num !== '').length-1;
            extraIp=count;
            
          programProcess.stdin.write(input + '\n');  
          
        };  
      }  
   
      if (inputCallback) {
        inputCallback(data.input);
        inputCallback = null; // Reset inputCallback after handling input
      } else {
      
        compileAndRunCode(data.language,data.code, ws);
      }  
    } catch (error) { 
      
      ws.send(JSON.stringify({output:`Error processing message: ${error.message}`}));
    }  
  });  
});  

 
function compileAndRunCode(language,code, ws) {
 let compiler; 
  let executionCommand;
  let fileExtension;
 let compilerProcess; 
  let modifiedCode = code;
  // let fileName= '' ;
  let fileName= '' ;
  extraIp = 0;

  switch (language) {
    case 'c':
      modifiedCode = code.replace(/scanf\s*\(/g, 'printf("i1n2p7u9t10");fflush(stdout);\nscanf(');
     

    fileName = '';
    
 
      compilerProcess = spawn('gcc', ['-o', 'm1a2i7n910','-x', 'c',  '-'],);
      executionCommand = path.join(__dirname,'m1a2i7n910');  
      
      break;
      case 'c++':
        modifiedCode = modifiedCode.replace(/cin\s*>>/g, 'cout << "i1n2p7u9t10";\nstd::cin>>');
        compiler = 'g++';
        executionCommand = './m1a2i7n910';
        fileExtension = '.cpp';
        compilerProcess = spawn('g++', ['-o', 'm1a2i7n910', '-x', 'c++', '-', '-std=c++11']); // Added -std=c++11 flag
        break;
        case 'java':
          
          fileName = code.match(/\s*[a-z]*\s*class\s*([a-zA-Z_][a-zA-Z0-9_]*)/)[1];
      
          modifiedCode = code.replace(/((;|}|{)\s*[a-zA-Z]*\s*[a-zA-Z_][a-zA-Z0-9_]*\s*([\[\s*[a-zA-Z_][a-zA-Z0-9_]*\s*\]\s*]*\s*)?=\s*[a-zA-Z0-9_]*\.next[a-zA-Z]*\(\))\s*;/g,
          function (matchedString){
            let prefix = matchedString[0];
            let suffix = matchedString.toString().substring(1);
            
            return `${prefix}\nSystem.out.println("i1n2p7u9t10");${suffix}`;
          }
          );
          fs.writeFileSync(`${fileName}.java`, modifiedCode, (err) => {
            if (err) {
              ws.send(JSON.stringify({output:`Error writing code to file: ${err.message}`}));
              return;
            }});
        
         compiler = 'javac';
         
          executionCommand = 'java';
          fileExtension = '.java';
          compilerProcess = spawn('javac', [`${fileName}.java`]); 
    
      break;
      case 'python':
         executionCommand = 'python'
     
         modifiedCode = code.replace(/(\s*input\s*\(\s*("[^"]*"|\s*)\s*)\)/g, `$1"i1n2p7u9t10")`);


         fs.writeFileSync(`m1a2i7n910.py`, modifiedCode, (err) => {
          if (err) {
            ws.send(JSON.stringify({output:`Error writing code to file: ${err.message}`}));
            return;
          }});
          fileName = path.join(__dirname,'m1a2i7n910.py');
         compilerProcess = spawn('node', ['-e','process.exit(0);']);
        
         break;
         

    default:
      ws.send('Unsupported language');
      return;
  }

  let compiledOutput = '';
  let runtimeOutput = '';
  
  compilerProcess.stdout.on('data', (data) => {
    compiledOutput += data.toString();
    ws.send(JSON.stringify({output:data.toString()}));

  });

  compilerProcess.stderr.on('data', (data) => {
    const error = data.toString();
    compiledOutput += `c10m9p7E2r1r: ${error}`;
    ws.send(JSON.stringify({output:`c10m9p7E2r1r: ${error}`}));

  });

  compilerProcess.on('error', (err) => {

    ws.send(JSON.stringify({output:`Compiler process error: ${err.message}`}));

  });

  
  compilerProcess.on('close', async (code) => {

    if (code === 0) {
    
      programProcess = spawn(executionCommand,[fileName]);
  
      programProcess.stdout.on('data', (data) => {
        
        if(data.length>100000){
          programProcess.kill();
        }
        else{
          runtimeOutput += data.toString();
          data.toString().replace(/\s*i1n2p7u9t10/g,function(match){
            extraIp--;
            
            return '';
          });
          ws.send(JSON.stringify({output:data.toString(),extraIp:extraIp}));
          
        }
        
      });
      programProcess.stderr.on('data', (data) => {
      
        const error = data.toString();
        runtimeOutput += `r10u9n7E2r1r: ${error}`;
        
        ws.send(JSON.stringify({output:`r10u9n7E2r1r: ${error}`}));

      });
      
      programProcess.on('error', (err) => {
        ws.send(JSON.stringify({output:`Program process error: ${err.message}`}));

      });
      
      programProcess.on('close', () => {
        if(language=='java'){
          
        fs.unlink(`${fileName}.java`, (err) => {
          if (err) {
            return;
          }
        });
        fs.unlink(`${fileName}.class`, (err) => {
          if (err) {
            return;
          }
        });

       
      
      } if(language=='python'){
          fs.unlink(fileName, (err) => {
            if (err) {
              return;
            }
          });
        }
        
      });
    } else {
      ws.send(JSON.stringify({output:`Compilation failed`}));

    }
  });

  compilerProcess.stdin.write(modifiedCode);
  compilerProcess.stdin.end();
}

server.listen(PORT, () => {
  console.log(`Backend listening on port ${PORT}`);
});

app.get('/',(req,res)=>{
  res.send("HELLO WORLD");
});


        
   




