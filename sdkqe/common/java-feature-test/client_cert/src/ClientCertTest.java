/**
 * Created by jaekwon.park on 6/23/17.
 */
import com.couchbase.client.java.*;
import com.couchbase.client.java.document.*;
import com.couchbase.client.java.document.json.*;
import com.couchbase.client.java.query.*;
import com.couchbase.client.java.env.CouchbaseEnvironment;
import com.couchbase.client.java.env.DefaultCouchbaseEnvironment;

public class ClientCertTest {
    public static void main(String []args) {

// Ports in the code according to cluster_run. Please remove the ports
// bootstrapHttpDirectPort, .bootstrapCarrierSslPort, .bootstrapHttpSslPort,
// .bootstrapCarrierDirectPort while using with couchbase package.
        CouchbaseEnvironment env = DefaultCouchbaseEnvironment
                .builder()
                .sslEnabled(true)
                .sslKeystoreFile("../cert/keystore.jks")
                .sslKeystorePassword("123456")
                .connectTimeout(50000)
                .computationPoolSize(5)
                .bootstrapCarrierSslPort(11207)
                .certAuthEnabled(true)
                .bootstrapHttpDirectPort(8091)
                .bootstrapHttpSslPort(18091)
                .bootstrapCarrierDirectPort(11210)
                .build();

        String[] nodes = {"172.23.123.176"};
        CouchbaseCluster cluster = CouchbaseCluster.create(env, nodes);

        try {
            Bucket bucket = cluster.openBucket("default");
// Create a JSON document and store it with the ID "helloworld"
            JsonObject content = JsonObject.create().put("hello", "world3");
            bucket.upsert(JsonDocument.create("java_client",content));

// Close all buckets and disconnect
            cluster.disconnect();
        } catch (Exception e) {
            System.out.printf("Exception:%s\n", e.toString());
        }

    }
}
