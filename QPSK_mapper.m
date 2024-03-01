% function symb = QPSK_mapper(bits)
%     %Encode bits as qpsk symbols
%         const = [(1+1i),(1-1i),(-1+1i),(-1-1i)]/sqrt(2); % Constellation: QPSK/4-QAM
%         m = buffer(bits, 2)';                            % Group bits into bits per symbol
%         m_idx = bi2de(m, 'left-msb')'+1;                 % Bits to symbol index
%         symb = const(m_idx);                             % Look up symbols using the indices
%     end

 function symb = QPSK_mapper(bits)
        % Encode bits as qpsk symbols 
        % ARGUMENTS:
        % bits = array of bits. Numerical values converted as:
        %   zero -> zero
        %   nonzero -> one
        % Must be of even length!
        % OUTPUT:
        % x = complex array of qpsk symbols encoding the bits. Will contain
        % length(bits)/2 elements. Valid output symbols are
        % 1/sqrt(2)*(+/-1 +/- i). Symbols grouped by pairs of bits, where
        % the first corresponds the real part of the symbol while the
        % second corresponds to the imaginary part of the symbol. A zero
        % bit should be converted to a negative symbol component, while a
        % nonzero bit should be converted to a positive symbol component.
        
        % Convert bits vector of +/- 1
        bits = double(bits);
        bits = bits(:);

        for i = 1:1:length(bits)
            if bits(i) == 0
                bits(i) = -1;
            else
                bits(i) = 1;
            end
        end

        if rem(length(bits),2) == 1
            error('bits must be of even length');
        end

        for k = 1:1:length(bits)/2
            symb(k) = sqrt(1/2)*(bits(2*k-1)+1i*bits(2*k));
        end

        symb = symb.';
    end