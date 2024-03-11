                                                                                                                               
 # Tunneling SSH Helper (tsh)                                                                                                  
                                                                                                                               
 This script, `tsh`, is a utility for managing SSH tunnels and executing commands through them. It simplifies the process of   
 starting, using, and managing SSH tunnels by automating the setup and teardown of `devtunnel` instances.                      
                                                                                                                               
 ## Features                                                                                                                   
                                                                                                                               
 - Automatic `devtunnel` instance management with reference counting.                                                          
 - Easy port forwarding setup.                                                                                                 
 - SSH session management through jump hosts.                                                                                  
 - Filesystem mounting over SSH.                                                                                               
 - Dynamic command execution with host and port interpolation.                                                                 
 - SSH config manipulation for easy ProxyJump configuration.                                                                   
 - Traffic forwarding over SSH using `sshuttle`.                                                                               
                                                                                                                               
 ## Prerequisites                                                                                                              
                                                                                                                               
 - `devtunnel` must be installed and accessible in your PATH.                                                                  
 - `ssh`, `sshuttle`, `sshfs`, and standard Unix utilities must be installed.                                                  
 - The script is intended to be used on systems with a Bash-compatible shell.                                                  
                                                                                                                               
 ## Installation                                                                                                               
                                                                                                                               
 1. Download the `tsh` script.                                                                                                 
 2. Make it executable: `chmod +x tsh`.                                                                                        
 3. Place it in a directory that is in your PATH, or invoke it with its full path.                                             
                                                                                                                               
 ## Usage                                                                                                                      
                                                                                                                               
 ```bash                                                                                                                       
 ./tsh [-t hosts] [*] <command> [args...]                                                                                      
                                                                                                                               

                                                            Options                                                            

 • -t, --target <hosts>: Specify target host(s). Multiple comma-separated hosts are used as jump hosts until the last one. If  
   no target is specified, the connection is made to the tunnel host.                                                          
 • *: Any other options are passed down to the underlying command.                                                             

                                                           Commands                                                            

 • cmd '<cmd>': Executes a command, interpolating the host and port to the forwarded port as $host and $port.                  
 • fs <remote> <local>: Mount a remote filesystem.                                                                             
 • fwd <remote> <local>: Forward a port to the target host.                                                                    
 • match <host>: Add a Match entry to the SSH config to ProxyJump using the tunnel.                                            
 • proxy: Forward traffic over SSH (using sshuttle).                                                                           
 • shell: Open an SSH session to the target.                                                                                   

Any additional arguments are passed down to the underlying command.                                                            


                                                           Examples                                                            

Start an SSH session to the target host:                                                                                       

                                                                                                                               
 ./tsh shell                                                                                                                   
                                                                                                                               

Forward local port 8080 to remote port 80:                                                                                     

                                                                                                                               
 ./tsh fwd 80 8080                                                                                                             
                                                                                                                               

Mount a remote filesystem:                                                                                                     

                                                                                                                               
 ./tsh fs /remote/path /local/mountpoint                                                                                       
                                                                                                                               

Execute a custom command:                                                                                                      

                                                                                                                               
 ./tsh cmd 'echo "Accessing port $port on $host"'                                                                              
                                                                                                                               


                                                            Cleanup                                                            

The script manages cleanup automatically upon exit. It will terminate the devtunnel instance if no other clients are running.  


                                                            License                                                            

This script is released under the MIT License.                                                                                 

                                                                                                                               
                                                                                                                               
 Please note that the above README assumes that the script is named `tsh` and that the user has a basic understanding of SSH a 
 tunneling concepts. Adjust the instructions as necessary to fit the actual deployment and usage scenarios.                    
                                                                                                                               