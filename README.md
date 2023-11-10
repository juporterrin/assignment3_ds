### 1.**Compile all classes**

```shell
make all
```





### 2.Introduction to each class

**Learner class**

```
This is the class to organize and store proposals, show all proposals
collect all votes from acceptors 
and finally annouce the winner.
```



**M1Server**

```
This is the proposer who responds to proposals instantly he receives one.
He also acts as acceptor.
He can send proposals to ask learner to create a proposal and store it.
He can send prepare message to inform each acceptor of an proposal about to be made.
```



**M2Server**

```
This is the proposer who responds to proposals with large delay, I designed this delay to be 8000ms.
He also acts as acceptor.
He can send proposals to ask learner to create a proposal and store it.
He can send prepare message to inform each acceptor of an proposal about to be made.
```

**M3Server**

```
This is the proposer who responds to proposals with small delay, I designed this delay to be 3000ms.
He also acts as acceptor.
he could go offline anytime.
He can send proposals to ask learner to create a proposal and store it.
He can send prepare message to inform each acceptor of an proposal about to be made.
```

**M4-M9**

```
They act as accetors only,
They can decide how long they would delay to respond to a proposal.
```



### 3.Start of each server

**Remember to start each start at a different terminal window**



**Learner**

```shell
javac Learner
```



**M1Server**

M1 always responds to proposals instantly

```shell
javac M1Server
```



**M2Server**

Without arguments: allows M2 to respond to a proposal with no delay

```
javac M2Server
```

With an argument: allow M2 to repond to a proposal with a large delay 8s.

```shell
javac M2Server delay
```



**M3Server**

Without arguments: allows M3 to respond to a proposal with no delay

```java
javac M3Server
```

With an argument: allow M3 to repond to a proposal with a small delay 8s.

```shell
javac M3Server delay
```



**M4-M9**

They have similar structure, I will only show how to start M4, and you can replace M4 with any other members to start the rest of servers.



Without arguments: allows M4 to respond to a proposal with no delay

```
javac M4Server
```

With an arguments: allows M4 to respond to a proposal with a delay of 4000ms, and you can also replace this value with any other values you wish M4 to delay.

```shell
javac M4Server 40000
```



### 4.Keyboard inputs of some servers

We can type something in the terminal to trigger an event, for example, we can type “sendProposal” in the M1 terminal window to write a proposal, then the terminal will alert you to enter the proposal’s content, once you type the content of the proposal, you press enter, this proposal will be sent to the Learner, and it will save it for later purpose.

**M1 M2 M3**

```
"sendProposal"


This keyboard input allows them to write a proposal, once press enter, they will inform Learner to create a proposal and store it in a hashmap.
```

```
"sendPrepareMessage"

This keyboard input allows them to send a message to each acceptor that they have made a proposal, and ask acceptors to vote for them.
```

**M3 only**

```
"goOffline"

This keyboard input allows M3 to go offline anytime.
```

**Learner**

```
"winner"

This will show the number of vote for each proposal.

if one of the numbers of vote is 0, it represents either the proposal is not created, or the proposal receives 0 votes.
```



### 5.Testing

**For a better testing experience, please start Learner and M1-M9 servers, and keep them running at the same time.**



#### 1.Paxos implementation works when two councillors send voting proposals at the same time.

Testing process:

```
Ask M1 and M2 to send a proposal at the same to see the proposals are stored correctly.
```



For M1 terminal:

```shell
M1's server started on port 8081
The initial sequence number is: 24793
sendProposal
Enter The Proposal: 
I am M1, I wanna be the president!                    
Sent a request to Learner to create a proposal for M1 
The proposal is I am M1, I wanna be the president!
Proposal Successfully sent!
```

For M2 terminal:

```shell
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M2Server
M2's server started on port 8082
The initial sequence number is: 21040
sendProposal
Enter The Proposal: 
I am M2, I wanna be the president more than anyone!
Sent a request to Learner to create a proposal for M2 
The proposal is I am M2, I wanna be the president more than anyone!
Proposal Successfully sent!

```



For Learner terminal:

```
Received proposal from M1: I am M1, I wanna be the president!
All Proposals:
****************************************************
Proposer: M1
Proposal Content: I am M1, I wanna be the president!
Sequence Number: 24793
                                                
****************************************************
                                                    
Received proposal from M2: I am M2, I wanna be the president more than anyone!
All Proposals:
****************************************************
Proposer: M1
Proposal Content: I am M1, I wanna be the president!
Sequence Number: 24793
                                                
Proposer: M2
Proposal Content: I am M2, I wanna be the president more than anyone!
Sequence Number: 21040
                                                
****************************************************

```











#### 2.Paxos implementation works in the caese where all M1-M9 have immediate responses to voting queries

Testing process:

```
1.Start all Learner and M1-M9 servers with no arguments, which means they respond with no delay.

2.M1 send a proposal, and then send prepare message to acceptors
3.Acceptors will decide if they accept this proposal based on if the sequence number of this proposal is the largest they have ever seen. Yes accpect, NO reject.
4.Leaner shows the number of votes, if there is someone proposal whose vote is more than 5(majority of half of the number of all members), if yes, this proposal wins, if no, someone should keep proposing, which means starting over the sendProposal and sendPrepareMessage processes.

```



M1 terminal:
M1 makes a proposal, and send a prepare message to each other acceptor to ask them to vote for him.

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M1Server
M1's server started on port 8081
The initial sequence number is: 47829
sendProposal
Enter The Proposal: 
I am M1, Please vote me!
Sent a request to Learner to create a proposal for M1 
The proposal is I am M1, Please vote me!
Proposal Successfully sent!
sendPrepareMessage
Enter the Message:
I have proposed, please chech it every one. M1:)    
Sent prepare message I have proposed, please chech it every one. M1:) to Server on the port: 8082!
Sent prepare message I have proposed, please chech it every one. M1:) to Server on the port: 8083!
Sent prepare message I have proposed, please chech it every one. M1:) to Server on the port: 8084!
Sent prepare message I have proposed, please chech it every one. M1:) to Server on the port: 8085!
Sent prepare message I have proposed, please chech it every one. M1:) to Server on the port: 8086!
Sent prepare message I have proposed, please chech it every one. M1:) to Server on the port: 8087!
Sent prepare message I have proposed, please chech it every one. M1:) to Server on the port: 8088!
Sent prepare message I have proposed, please chech it every one. M1:) to Server on the port: 8089!
Message Successfully sent!

```

M2 terminal
M2 rejects this proposal, because M1’s proposal’s sequence number is not the largest that M2 has ever seen.

```shell
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M2Server
M2's server started on port 8082
The initial sequence number is: 64678
Message received and processed from port 8081, saying: I have proposed, please chech it every one. M1:)
Max sequenceNumber in history is : ：64678
Currently received sequenceNumber is: ：47829
I am considering to reject the proposal, since the current sequenceNumber is not max

```

M3 Terminal

M3 rejects this proposal, because M1’s proposal’s sequence number is not the largest that M3 has ever seen.

```shell
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M3Server
The initial sequence number is: 48436
M3's server started on port 8083
The initial sequence number is: 48436
Message received and processed from port 8081, saying: I have proposed, please chech it every one. M1:)
Max sequenceNumber in history is : ：48436
Currently received sequenceNumber is: ：47829
I am considering to reject the proposal, since the current sequenceNumber is not max

```

M4 Terminal

M4 rejects this proposal, because M1’s proposal’s sequence number is not the largest that M4 has ever seen.

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M4Server
M4's server started on port 8084
The initial sequence number is: 67909
Message received and processed from port 8081, saying: I have proposed, please chech it every one. M1:)
Max sequenceNumber in history is : ：67909
Currently received sequenceNumber is: ：47829
I am considering to reject the proposal, since the current sequenceNumber is not max
```

M5 terminal

M5 rejects this proposal, because M1’s proposal’s sequence number is not the largest that M5 has ever seen.

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M5Server
M5's server started on port 8085
The initial sequence number is: 49130
Message received and processed from port 8081, saying: I have proposed, please chech it every one. M1:)
Max sequenceNumber in history is : ：49130
Currently received sequenceNumber is: ：47829
I am considering to reject the proposal, since the current sequenceNumber is not max
```

M6 terminal

M6 rejects this proposal, because M1’s proposal’s sequence number is not the largest that M6 has ever seen.

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M6Server
M6's server started on port 8086
The initial sequence number is: 64709
Message received and processed from port 8081, saying: I have proposed, please chech it every one. M1:)
Max sequenceNumber in history is : ：64709
Currently received sequenceNumber is: ：47829
I am considering to reject the proposal, since the current sequenceNumber is not max

```

M7 terminal

M7 rejects this proposal, because M1’s proposal’s sequence number is not the largest that M7 has ever seen.

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M7Server
M7's server started on port 8087
The initial sequence number is: 69961
Message received and processed from port 8081, saying: I have proposed, please chech it every one. M1:)
Max sequenceNumber in history is : ：69961
Currently received sequenceNumber is: ：47829
I am considering to reject the proposal, since the current sequenceNumber is not max

```

M8 terminal

M8 accepts this proposal

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M8Server
M8's server started on port 8088
The initial sequence number is: 24882
Message received and processed from port 8081, saying: I have proposed, please chech it every one. M1:)
Max sequenceNumber in history is : ：24882
Currently received sequenceNumber is: ：47829
Current sequenceNumber is largest in history, considering to accept

```

M9 terminal

M9 accepts this proposal

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M9Server
M9's server started on port 8089
The initial sequence number is: 42514
Message received and processed from port 8081, saying: I have proposed, please chech it every one. M1:)
Max sequenceNumber in history is : ：42514
Currently received sequenceNumber is: ：47829
Current sequenceNumber is largest in history, considering to accept

```

Learner terminal

shows that M1’s proposal got 2 votes from M8 and M9.

In this case , there is no one proposal whose vote is more than 5, which means someone should keep proposing until the ocurrence of one proposal whose vote is more than 5, and eventaully Learner will annouce the winner.

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java Learner
Learner's server started on port 8090
Received proposal from M1: I am M1, Please vote me!
All Proposals:
****************************************************
Proposer: M1
Proposal Content: I am M1, Please vote me!
Sequence Number: 47829
                                                
****************************************************
                                                    
M8 voted for: M1
M9 voted for: M1
winner
Count M1: 2
Count M2: 0
Count M3: 0
There is no winner since no proposals have more than 5 votes, please keep proposing!

```





#### 3.Paxos implementation works when M1-M9 have responses to voting queries suggested by serveral profiles(immediate response, small delay, large delay, and no response),including M3 goes offline.



Testing process

```
1.Start all server with arguments if possible
2.M1 and M2 send proposals, and send Prepare Message, and then M3 goes offline.
3.Similarly, acceptors will decide if they accept these proposals based on the aforementioned rules.
4.Leaner will display the votes and winner.

```

M1 terminal

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M1Server
M1's server started on port 8081
The initial sequence number is: 72503
sendProposal
Enter The Proposal: 
I am M1, please vote me 
Sent a request to Learner to create a proposal for M1 
The proposal is I am M1, please vote me
Proposal Successfully sent!
Message received and processed from port 8082, saying: I am M2, please vote me
Max sequenceNumber in history is: ：72503
Currently received sequenceNumber is: ：68157
I am considering to reject the proposal, since the current sequenceNumber is not max
sendPrepareMessage
Enter the Message:
I am M1, please vote m1
Sent prepare message I am M1, please vote m1 to Server on the port: 8082!
Sent prepare message I am M1, please vote m1 to Server on the port: 8083!
Sent prepare message I am M1, please vote m1 to Server on the port: 8084!
Sent prepare message I am M1, please vote m1 to Server on the port: 8085!
Sent prepare message I am M1, please vote m1 to Server on the port: 8086!
Sent prepare message I am M1, please vote m1 to Server on the port: 8087!
Sent prepare message I am M1, please vote m1 to Server on the port: 8088!
Sent prepare message I am M1, please vote m1 to Server on the port: 8089!
Message Successfully sent!

```

M2 terminal

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M2Server delay
M2's server started on port 8082
The initial sequence number is: 68157
sendProposal
Enter The Proposal: 
I am M2, vote me
Sent a request to Learner to create a proposal for M2 
The proposal is I am M2, vote me
Proposal Successfully sent!
sendPrepareMessage                                    
Enter the Message:
I am M2, please vote me           
Sent prepare message I am M2, please vote meto Server on the port: 8081!
Sent prepare message I am M2, please vote meto Server on the port: 8083!
Sent prepare message I am M2, please vote meto Server on the port: 8084!
Sent prepare message I am M2, please vote meto Server on the port: 8085!
Sent prepare message I am M2, please vote meto Server on the port: 8086!
Sent prepare message I am M2, please vote meto Server on the port: 8087!
Sent prepare message I am M2, please vote meto Server on the port: 8088!
Sent prepare message I am M2, please vote meto Server on the port: 8089!
Successfully sent!
Message received and processed from port 8081, saying: I am M1, please vote m1
Max sequenceNumber in history is : ：98157
Currently received sequenceNumber is: ：72503
M3 delaying.....
I am considering to reject the proposal, since the current sequenceNumber is not max

```

M3 terminal

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M3Server delay
The initial sequence number is: 48559
M3's server started on port 8083
The initial sequence number is: 48559
Message received and processed from port 8082, saying: I am M2, please vote me
Max sequenceNumber in history is : ：48559
Currently received sequenceNumber is: ：68157
M3 delaying.....
true
Current sequenceNumber is largest in history, considering to accept
Message received and processed from port 8081, saying: I am M1, please vote m1
Max sequenceNumber in history is : ：68157
Currently received sequenceNumber is: ：72503
M3 delaying.....
true
Current sequenceNumber is largest in history, considering to accept
goOffline
zhengyu@Zhengs-MacBook-Pro Assignment3 % 

```

M4 terminal

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M4Server 1000
M4's server started on port 8084
The initial sequence number is: 54675
Message received and processed from port 8082, saying: I am M2, please vote me
Max sequenceNumber in history is : ：54675
Currently received sequenceNumber is: ：68157
M4 delaying.....
Current sequenceNumber is largest in history, considering to accept
Message received and processed from port 8081, saying: I am M1, please vote m1
Max sequenceNumber in history is : ：68157
Currently received sequenceNumber is: ：72503
M4 delaying.....
Current sequenceNumber is largest in history, considering to accept


```

M5 Terminal

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M5Server 2000
M5's server started on port 8085
The initial sequence number is: 68402
Message received and processed from port 8082, saying: I am M2, please vote me
Max sequenceNumber in history is : ：68402
Currently received sequenceNumber is: ：68157
M5 delaying.....
I am considering to reject the proposal, since the current sequenceNumber is not max
Message received and processed from port 8081, saying: I am M1, please vote m1
Max sequenceNumber in history is : ：68402
Currently received sequenceNumber is: ：72503
M5 delaying.....
Current sequenceNumber is largest in history, considering to accept

```

M6 terminal

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M6Server 3000
M6's server started on port 8086
The initial sequence number is: 76873
Message received and processed from port 8082, saying: I am M2, please vote me
Max sequenceNumber in history is : ：76873
Currently received sequenceNumber is: ：68157
M6 delaying.....
I am considering to reject the proposal, since the current sequenceNumber is not max
Message received and processed from port 8081, saying: I am M1, please vote m1
Max sequenceNumber in history is : ：76873
Currently received sequenceNumber is: ：72503
M6 delaying.....
I am considering to reject the proposal, since the current sequenceNumber is not max
```

M7 terminal

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M7Server 4000
M7's server started on port 8087
The initial sequence number is: 64257
Message received and processed from port 8082, saying: I am M2, please vote me
Max sequenceNumber in history is : ：64257
Currently received sequenceNumber is: ：68157
M7 delaying.....
Current sequenceNumber is largest in history, considering to accept
Message received and processed from port 8081, saying: I am M1, please vote m1
Max sequenceNumber in history is : ：68157
Currently received sequenceNumber is: ：72503
M7 delaying.....
Current sequenceNumber is largest in history, considering to accept

```

M8 terminal

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M8Server 5000
M8's server started on port 8088
The initial sequence number is: 41027
Message received and processed from port 8082, saying: I am M2, please vote me
Max sequenceNumber in history is : ：41027
Currently received sequenceNumber is: ：68157
M8 delaying.....
Current sequenceNumber is largest in history, considering to accept
Message received and processed from port 8081, saying: I am M1, please vote m1
Max sequenceNumber in history is : ：68157
Currently received sequenceNumber is: ：72503
M8 delaying.....
Current sequenceNumber is largest in history, considering to accept

```

M9 terminal

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java M9Server 6000 
M9's server started on port 8089
The initial sequence number is: 69026
Message received and processed from port 8082, saying: I am M2, please vote me
Max sequenceNumber in history is : ：69026
Currently received sequenceNumber is: ：68157
M9 delaying.....
I am considering to reject the proposal, since the current sequenceNumber is not max
Message received and processed from port 8081, saying: I am M1, please vote m1
Max sequenceNumber in history is : ：69026
Currently received sequenceNumber is: ：72503
M9 delaying.....
Current sequenceNumber is largest in history, considering to accept

```

Learner terminal

```
zhengyu@Zhengs-MacBook-Pro Assignment3 % java Learner
Learner's server started on port 8090
Received proposal from M1: I am M1, please vote me
All Proposals:
****************************************************
Proposer: M1
Proposal Content: I am M1, please vote me
Sequence Number: 72503
                                                
****************************************************
                                                    
Received proposal from M2: I am M2, vote me
All Proposals:
****************************************************
Proposer: M2
Proposal Content: I am M2, vote me
Sequence Number: 68157
                                                
Proposer: M1
Proposal Content: I am M1, please vote me
Sequence Number: 72503
                                                
****************************************************
                                                    
M4 voted for: M2
M7 voted for: M2
M8 voted for: M2
M3 voted for: M2
M4 voted for: M1
M5 voted for: M1
M7 voted for: M1
M8 voted for: M1
M9 voted for: M1
M3 voted for: M1
winner
Count M1: 6
Count M2: 4
Count M3: 0
Winner is M1

```

