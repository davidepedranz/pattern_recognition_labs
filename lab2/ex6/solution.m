clear;
format long;

p_spam = 0.9;
p_non_spam = 1 - p_spam;

[spam_map, non_spam_map] = db();

sentences = {
    'We offer our dear customers a wide selection of classy watches.'
    'Did you have fun on vacation? I sure did!'
};

% first sentence
disp('[Sentence 1]');
disp(sentences{1});
disp('');
[p_spam_1, p_non_spam_1, p_spam_un_1, p_non_spam_un_1] = naive_baises(p_spam, p_non_spam, sentences{1});
disp('[Sentence 1] Nominator in Bayes formula for the posterior probability of the e-mail being spam');
disp(p_spam_un_1);
disp('[Sentence 1] Nominator in Bayes formula for the posterior probability of the e-mail non being spam');
disp(p_non_spam_un_1);
disp('[Sentence 1] Ratio spam / non spam');
disp(p_spam_un_1 / p_non_spam_un_1);
disp(p_spam_1 / p_non_spam_1);

% second sentence
disp('[Sentence 2]');
disp(sentences{1});
disp('');
[p_spam_2, p_non_spam_2, p_spam_un_2, p_non_spam_un_2] = naive_baises(p_spam, p_non_spam, sentences{2});
disp('[Sentence 2] P(spam)');
disp(p_spam_2);
disp('[Sentence 2] P(non spam)');
disp(p_non_spam_2);
disp('[Sentence 2] Nominator in Bayes formula for the posterior probability of the e-mail being spam');
disp(p_spam_un_2);
disp('[Sentence 2] Nominator in Bayes formula for the posterior probability of the e-mail non being spam');
disp(p_non_spam_un_2);
disp('[Sentence 2] Ratio spam / non spam');
disp(p_spam_un_2 / p_non_spam_un_2);
disp(p_spam_2 / p_non_spam_2);



