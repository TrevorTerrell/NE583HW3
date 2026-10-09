function plotMultiplicationOfN(mult)
    plot(0:(length(mult) - 1), mult, Marker = "o", LineWidth = 2)
    xlabel("Number of slabs")
    ylabel("Multiplication")
    grid("on")
end