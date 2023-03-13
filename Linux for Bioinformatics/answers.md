Q1: What is your home directory? 
A: `/home/ubuntu`

Q2: What is the output of this command?
A: `hello_world.txt`

Q3: What is the output of each ls command?
A:  `ls my_folder`: does not return anything (empty)
    `ls my_folder2`: `hello_world.txt`
    
Q4: What is the output of each?
A:  `ls my_folder`: does not return anything (empty).
    `ls my_folder2`: does not return anything (empty).
    `ls my_folder3`: `hello_world.txt`
    
Q5: What editor did you use and what was the command to save your file changes?
A: I used Nano as an editor. To save my file, I used `CTRL-O`. To exit, I used `CTRL-X`.

Q6: What is the error? 
A: I get the following error : `Permission Denied (Public Key)`

Q7: What was the solution?
A: To fix the issue, I performed the following steps:
  1. Created a new .ssh directory in the sudouser home directory: `mkdir .ssh`
  2. Changed permissions so that only sudouser can read, write, or open .ssh directory: `chmod 700 .ssh`
  3. Create an authorized keys file in the .ssh directory: `touch .ssh/authorized_keys`
  4. Changed permissions so that only sudouser can read or write to .ssh/authorized_keys: `chmod 600 .ssh/authorized_keys`
  5. Created a public key from the private key on my machine: `ssh-keygen -y -f keypair.pem`
  6. Used nano to copy the contents into .ssh/authorized_keys - saved and exited
  7. Connected to sudouser using the following command: `ssh -i keypair.pem sudouser@ec2_url.com`
  
Q8: What does the sudo docker run part of the command do? and what does the salmon swim part of the command do?
A: The command `sudo docker run` creates and runs a new container from an image (this case, `combine\salmon` image). According to the `salmon` documentation, `salmon swim` performs the `swim` command, which performs a super-secret operation.

Q9: What is the output of this command?
A: serveruser is not in the sudoers file.  This incident will be reported.

