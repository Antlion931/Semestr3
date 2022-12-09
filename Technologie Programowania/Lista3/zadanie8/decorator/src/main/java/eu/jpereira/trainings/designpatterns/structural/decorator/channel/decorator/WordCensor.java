package eu.jpereira.trainings.designpatterns.structural.decorator.channel.decorator;

import eu.jpereira.trainings.designpatterns.structural.decorator.channel.SocialChannel;

public class WordCensor extends SocialChannelDecorator {

	private String wordToCensor;

	public WordCensor(String word) {
		wordToCensor = word;
	}

	public WordCensor(String word, SocialChannel decoratedChannel) {
		wordToCensor = word;
		this.delegate = decoratedChannel;
	}

	@Override
	public void deliverMessage(String message) {
		delegate.deliverMessage(message.replaceAll(wordToCensor, "###"));
	}
}
