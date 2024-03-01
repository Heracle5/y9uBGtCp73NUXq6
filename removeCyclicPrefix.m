
%% function to remove cyclic prefix


function signal_without_cp = removeCyclicPrefix(signal_cp, length_cp)

    signal_without_cp = signal_cp(length_cp+1:end);

end