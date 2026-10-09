function plotCurrentOfN(J_right)
    plot(0:(length(J_right) - 1), J_right, Marker = "o", LineWidth = 2)
    xlabel("Number of slabs")
    ylabel("Transmitted Current")
    grid("on")
end