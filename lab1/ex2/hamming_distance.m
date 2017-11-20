function [value] = hamming_distance(a, b)
    assert(length(a) == length(b));
    mask = (a ~= 2) & (b ~= 2);
    a_masked = a(mask);
    b_masked = b(mask);
    value = sum(((a_masked(:) == b_masked(:)) == 0) / size(a_masked(:), 1));
end
