function result = iff(condition, a, b)
    result = (condition) .* a + (~condition) .* b;
end
