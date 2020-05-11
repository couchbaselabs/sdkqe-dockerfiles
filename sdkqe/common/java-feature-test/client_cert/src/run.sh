#!/bin/bash
rm  ClientCertTest.class
javac -cp ../lib/java-client-2.4.7-SNAPSHOT.jar:../lib/core-io-1.4.7-SNAPSHOT.jar:../lib/rxjava-1.2.7.jar:. ClientCertTest.java
java -cp ../lib/java-client-2.4.7-SNAPSHOT.jar:../lib/core-io-1.4.7-SNAPSHOT.jar:../lib/rxjava-1.2.7.jar:. ClientCertTest
