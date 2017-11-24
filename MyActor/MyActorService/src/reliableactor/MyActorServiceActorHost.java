package reliableactor;

import java.time.Duration;

import java.util.logging.Level;
import java.util.logging.Logger;

import microsoft.servicefabric.actors.ActorRuntime;
import microsoft.servicefabric.actors.FabricActorService;

public class MyActorServiceActorHost {

private static final Logger logger = Logger.getLogger(MyActorServiceActorHost.class.getName());
    /* 
    This is the entry point of the service host process.
    */
    public static void main(String[] args) throws Exception {
        
        try {

            /*
            This line registers an Actor Service to host your actor class with the Service Fabric runtime.
            For more information, see http://aka.ms/servicefabricactorsplatform
            */
            ActorRuntime.registerActorAsync(MyActorServiceImpl.class, (context, actorType) -> new FabricActorService(context, actorType, (a,b)-> new MyActorServiceImpl(a,b)), Duration.ofSeconds(10));
            Thread.sleep(Long.MAX_VALUE);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Exception occured ", e);
            throw e;
        }
    }
}

