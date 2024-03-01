% function symb = QPSK_demapper(bits)
%     %Encode bits as qpsk symbols
%         const = [(1+1i),(1-1i),(-1+1i),(-1-1i)]/sqrt(2); % Constellation: QPSK/4-QAM
%         m = buffer(bits, 2)';                            % Group bits into bits per symbol
%         m_idx = bi2de(m, 'left-msb')'+1;                 % Bits to symbol index
%         symb = const(m_idx);                             % Look up symbols using the indices
%     end

    function bits = QPSK_demapper(x)
        % Convert qpsk symbols to bits.
        % Output will be a vector twice as long as the input x, with values
        % 0 or 1.
        x = x(:);
        bits = false(2*length(x),1);
        % Note: you only need to check which quadrant of the complex plane
        % the symbol lies in in order to map it to a pair of bits. The
        % first bit corresponds to the real part of the symbol while the
        % second bit corresponds to the imaginary part of the symbol.

        bits_double = zeros(length(x),2);

        for k = 1:1:length(x)
            if real(x(k)) > 0 && imag(x(k)) > 0
                bits_double(k,:) = [1, 1];
            elseif real(x(k)) < 0 && imag(x(k)) > 0
                bits_double(k,:) = [-1, 1];
            elseif real(x(k)) > 0 && imag(x(k)) < 0
                bits_double(k,:) = [1, -1];
            elseif real(x(k)) < 0 && imag(x(k)) < 0
                bits_double(k,:) = [-1, -1];
            end
        end

        for l = 1:1:length(bits_double)
            if l == 1
                bits_org = [bits_double(l,:)];
            else
                bits_org = [bits_org, bits_double(l,:)];
            end
        end

        bits = bits_org.';

        bits(bits ~= -1) = 1;
        bits(bits == -1) = 0;

        % Ensure output is of correct type
        % zero value -> logical zero
        % nonzero value -> logical one
        bits = logical(bits);
    end