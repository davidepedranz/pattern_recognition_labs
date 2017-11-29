function [spam_map, non_spam_map] = db()
    words = {
        'anti-aging'
        'customers'
        'fun'
        'groningen'
        'lecture'
        'money'
        'vacation'
        'viagra' 
        'watches'
    };
    spam = [
        0.00062
        0.005
        0.00015
        0.00001
        0.000015
        0.002
        0.00025
        0.001
        0.0003
    ];
    non_spam = [
        0.000000035
        0.0001
        0.0007
        0.001
        0.0008
        0.0005
        0.00014
        0.0000003
        0.000004
    ];

    spam_map = containers.Map(words, spam);
    non_spam_map = containers.Map(words, non_spam);
end

