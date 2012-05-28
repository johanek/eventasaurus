# Eventasaurus

Eventasaurus is a framework for delivering notification for events to multiple output streams.

How it works
------------

Producers create JSON encoded messages that are sent to a virtual topic via stomp

Consumers read those messages on their own queue for that virtual topic

The JSON looks like

        {	
          "timestamp" => "2012-05-21T20:58:36Z",    # ISO8601 time
          "ident" => "event",                       # Identity of producer, string
          "tags" => ["sample", "test"],             # Tags for message, array, optional
          "message" => "this is a sample event"     # Message body, string
        }

Producers
---------

* eventasaurus-rex:   creates a properly formatted notification to send to a topic, and is usable as a command line interface scripts
* producer:           an example showing how to deliver messages directly to a topic

Consumers
---------

* couchdb:        send all events to a couchdb instance
* jabber:         send all events to a XMPP/Jabber chat room
* mailer:         send events matching ident to a specific email address
* statusnet:      send events matching ident to a statusnet account
* stdout:         example showing how to read events using eventasaurus library
* twitter_crap:   example showing how to send events to a twitter account

Launcher
--------

launcher reads /etc/eventasaurus/config.yaml and launches various consumers as defined. consumers are created as standalone applications to allow them to be written in any language, but launched by this script.

The config looks like
        consumer-app-with-filter:
          filters:
            - a
            - b
          options:
            a:
              p: q
              r: s
            b:
              w: x
              y: z
        consumer-app-no-filter:
          filters:
            - all
        consumer-app-no-filter-with-options:
          filters:
            - all
          options:
            a: b

Which will run the following commands
		consumer-app-with-filter --ident a --p q --r s <action>
		consumer-app-with-filter --ident b --w x --y z <action>
		consumer-app-no-filter <action>
		consumer-app-no filter-with-options --a b <action>

With action being one of stop, start or restart.
		
TODO: define config file format
