package eu.jpereira.trainings.designpatterns.structural.decorator.channel.decorator;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

import eu.jpereira.trainings.designpatterns.structural.decorator.channel.SocialChannel;
import eu.jpereira.trainings.designpatterns.structural.decorator.channel.SocialChannelBuilder;
import eu.jpereira.trainings.designpatterns.structural.decorator.channel.SocialChannelProperties;
import eu.jpereira.trainings.designpatterns.structural.decorator.channel.SocialChannelPropertyKey;
import eu.jpereira.trainings.designpatterns.structural.decorator.channel.spy.TestSpySocialChannel;

public class ChainCensorDecoratorTest extends AbstractSocialChanneldDecoratorTest {
    @Test
	public void testChainTwoDecorators() {
		// Create the builder
		SocialChannelBuilder builder = createTestSpySocialChannelBuilder();

		// create a spy social channel
		SocialChannelProperties props = new SocialChannelProperties().putProperty(SocialChannelPropertyKey.NAME, TestSpySocialChannel.NAME);

		// Chain decorators
		SocialChannel channel = builder.
				with(new MessageTruncator(10)).
				with(new URLAppender("http://jpereira.eu")).
                with(new WordCensor("this")).
				getDecoratedChannel(props);

		channel.deliverMessage("this is a message");
		// Spy channel. Should get the one created before
		TestSpySocialChannel spyChannel = (TestSpySocialChannel) builder.buildChannel(props);
		assertEquals("### is... http://jpereira.eu", spyChannel.lastMessagePublished());
	}
}
