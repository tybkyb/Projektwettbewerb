%% Überprüfung auf Steuer- und Beobachtbarkeit
[m, ~] = size(A);
if rank([B, A*B, A^2*B, A^3*B]) == m
    disp('System ist steuerbar')
else
    disp('System ist nicht steuerbar')
end

if rank([C; C*A; C*A^2; C*A^3]) == m
    disp('System ist beobachtbar')
else
    disp('System ist nicht beobachtbar')
end