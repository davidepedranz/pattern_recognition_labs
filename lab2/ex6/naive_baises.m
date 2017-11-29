function [p_spam, p_non_spam, p_spam_unnoormalized, p_non_spam_unnoormalized] = naive_baises(p_prior_spam, p_prior_non_spam, sentence)
    
    % pre-process sentence
    tokens = strsplit(lower(sentence), {' ', '.', '?', '!'}, 'CollapseDelimiters', true);
    
    % read database
    % TODO: move outside
    [spam_map, non_spam_map] = db();
    
    % compute P(spam)
    p_spam_unnoormalized = p_prior_spam;
    for token = tokens
        if spam_map.isKey(token)
            p = spam_map(char(token));
            p_spam_unnoormalized = p_spam_unnoormalized * p;
        end
    end
    
    % compute P(non_spam)
    p_non_spam_unnoormalized = p_prior_non_spam;
    for token = tokens
        if non_spam_map.isKey(token)
            p = non_spam_map(char(token));
            p_non_spam_unnoormalized = p_non_spam_unnoormalized * p;
        end
    end
        
    % normalize probabilities
    normalization = p_spam_unnoormalized + p_non_spam_unnoormalized;
    p_spam = p_spam_unnoormalized / normalization;
    p_non_spam = p_non_spam_unnoormalized / normalization;
end

