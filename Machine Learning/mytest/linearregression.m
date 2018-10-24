function [theta, J_history] = linearregression(X, y, alpha, iter_num)
	m = length(y);
	ones_X = ones(m, 1);
	X_input = [ones_X, X];
	theta = zeros(size(X_input,2), 1);

	for iter = 1:iter_num
		h = X_input*theta;
		J = 1/(2*m)*sum((h.-y).^2);
		theta = theta - alpha/m*((h-y)'*X_input)';

		J_history(iter) = J;
	end

	%theta
	plot(X, y, 'rx', 'markersize', 10);
	hold on;
	plot(X, X_input*theta, 'b-');

end