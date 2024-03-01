
% function to add cyclic prefix

% removal of CP
% filter_output(L+1:end)


function input_signal_cp = addCyclicPrefix(input_signal, channel_coffecients, prefix_length_option, prefix_length)
    
    N = length(input_signal); % Length of input signal
    
    switch prefix_length_option
        case 'prefix_length_as_channel_length'
            L = length(channel_coffecients); % Length of channel
            cyclic_prefix = input_signal(N-L+1:N);  % last samples of input signal as the CP
            input_signal_cp  = [cyclic_prefix input_signal];  % prepend signal with CP
    
        case 'manual_length'
            L = prefix_length;
            cyclic_prefix = input_signal(N-L+1:N);  % last samples of input signal as the CP
            input_signal_cp  = [cyclic_prefix input_signal];

end





