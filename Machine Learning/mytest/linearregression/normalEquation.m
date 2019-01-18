function theta = normalEquation(X, y, lambda)
    [m, n]=size(X);
    L=eye(n, n);
    L(1, 1)=0;
	theta=pinv(X'*X+lambda.*L)*X'*y;
	fprintf('Calculate theta via normal equation with lambda: %f\n', lambda);
end
