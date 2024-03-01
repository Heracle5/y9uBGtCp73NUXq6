
%% function to add cyclic prefix
% CP should only work if longer than channel impulse response


function input_signal_cp = addCyclicPrefix(input_signal, channel_coffecients, prefix_length_option, prefix_length)
    
    N = length(input_signal); % Length of input signal
    
    switch prefix_length_option
        case 'auto'  % the automatic option provides a prefix that is channel length + 1 long
            L = length(channel_coffecients); % Length of channel
            cyclic_prefix = input_signal(N-L:N);  % last samples of input signal as the CP
            input_signal_cp  = [cyclic_prefix input_signal];  % prepend signal with CP
    
        case 'manual'
            L = prefix_length; % Length of channel
            cyclic_prefix = input_signal(N-L+1:N);  % last samples of input signal as the CP
            input_signal_cp  = [cyclic_prefix input_signal];
    end

end