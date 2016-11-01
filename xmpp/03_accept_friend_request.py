import sys
import logging
import getpass
from optparse import OptionParser

import sleekxmpp

# Python versions before 3.0 do not use UTF-8 encoding
# by default. To ensure that Unicode is handled properly
# throughout SleekXMPP, we will set the default encoding
# ourselves to UTF-8.
if sys.version_info < (3, 0):
    reload(sys)
    sys.setdefaultencoding('utf8')
else:
    raw_input = input

# Setup logging.
logging.basicConfig(level='INFO', format='%(levelname)-8s %(message)s')
logger = logging.getLogger('send_message')

class SendMsgBot(sleekxmpp.ClientXMPP):

    """
    A basic SleekXMPP bot that will log in, send a message,
    and then log out.
    """

    def __init__(self, sender_jid, sender_password, message, recipient_jid):
        sleekxmpp.ClientXMPP.__init__(self, sender_jid, sender_password)

        # Accept all friend requests (This is the default value, it's here just to be explicit)
        self.auto_authorize = True

        # The message we wish to send, and the JID that will receive it.
        self.message = message
        self.recipient_jid = recipient_jid

        # The session_start event will be triggered when
        # the bot establishes its connection with the server
        # and the XML streams are ready for use. We want to
        # listen for this event so that we we can initialize
        # our roster.
        self.add_event_handler("session_start", self.start)
        # Discard SSL invalid cert
        self.add_event_handler("ssl_invalid_cert", self.discard)

    # login, send message, log out.
    def start(self, event):
        # Process the session_start event.
        self.send_presence()
        self.get_roster()
        self.send_message(mto=self.recipient_jid, mbody=self.message, mtype='chat')

    # Discard SSL invalid cert
    def discard(self, event):
        logger.warning('******************** ssl_invalid_cert')
        logger.warning(event)
        return

if __name__ == '__main__':
    host = '54.145.200.149'
    sender_jid = 'test2@' + host
    sender_password = 'test'

    message = 'Hello from test2!'
    recipient_jid = 'test1@' + host

    # Setup the EchoBot and register plugins. Note that while plugins may
    # have interdependencies, the order in which you register them does
    # not matter.
    xmpp = SendMsgBot(sender_jid, sender_password, message, recipient_jid)
    xmpp.register_plugin('xep_0030') # Service Discovery
    xmpp.register_plugin('xep_0199') # XMPP Ping

    # If you are working with an OpenFire server, you may need
    # to adjust the SSL version used:
    # xmpp.ssl_version = ssl.PROTOCOL_SSLv3

    # If you want to verify the SSL certificates offered by a server:
    # xmpp.ca_certs = "path/to/ca/cert"

    # Connect to the XMPP server and start processing XMPP stanzas.
    if xmpp.connect():
        xmpp.process(block=True)
        print("Done")
    else:
        print("Unable to connect.")
