package reliableactor.test;

import reliableactor.MyActorService;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.concurrent.ExecutionException;

import microsoft.servicefabric.actors.ActorExtensions;
import microsoft.servicefabric.actors.ActorId;
import microsoft.servicefabric.actors.ActorProxyBase;

public class MyActorServiceTestClient {

    /**
    * @param args the command line arguments
    */
    public static void main(String[] args) throws URISyntaxException, InterruptedException, ExecutionException {
        MyActorService actorProxy = ActorProxyBase.create(new ActorId("From Actor 1"), new URI("fabric:/MyActor/MyActorServiceService"), MyActorService.class);
        int count = actorProxy.getCountAsync().get();
        System.out.println("From Actor:" + ActorExtensions.getActorId(actorProxy) + " CurrentValue:" + count);
        actorProxy.setCountAsync(count + 1).get();
    }
}
