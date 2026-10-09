function plotMultOfCurrent(J_right, mult)
    plot(J_right, mult, Marker = "o", LineWidth = 2)
    xlabel("Transmitted Current")
    ylabel("Multiplication")
    grid("on")
end