**How to build cert and run test**

1. Generate keys and activate.<br/>
Go to 'cert' directory and run **./gen_keystore.sh \<IP of the couchbase host\>**, so all required keys, certificate will be generated and copied and activated to target IP. Also, this creates keystore file with user name 'sdkqecertuser'
2. Build Java SDK<br/>
Go to 'lib' directory and run **./build_jar.sh**, which will build three jar files required to run example code.
3. Create a user with a name '**sdkqecertuser**' with the role you want.<br/>
4. Compile example code and run<br/>
Go to 'src' and open **ClientCertTest.java** and *change IP of server from "**172.23.123.175**" to the IP of your couchbase node*. Then run **./run.sh** which will compile and run test

To verify, check couchbase UI and see if you can find key 'hello' and value 'world3' created.
