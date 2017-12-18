function points = make_grid(bottom_left, top_right, samples)
    step_xs = (top_right(1) - bottom_left(1)) / samples(1);
    xs = bottom_left(1) : step_xs : top_right(1);
    step_ys = (top_right(2) - bottom_left(2)) / samples(2);
    ys = bottom_left(2) : step_ys : top_right(2);
    [XS, YS] = meshgrid(xs, ys);
    points = [XS(:), YS(:)];
end
