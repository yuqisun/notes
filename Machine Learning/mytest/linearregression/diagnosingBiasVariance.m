function [d_vec, J_vec, J_cv_vec, d_min, theta_min] = diagnosingBiasVariance(X_train, y_train, X_cv, y_cv, d_num)
	m=length(y_train);
	m_cv=length(y_cv);
	
	X_d=ones(m,1);
	X_cv_d=ones(m_cv,1);

	J_cv_temp=Inf;
	for d=1:d_num
		X_d=[ones(m,1) polynomialDegreeFeatures(X_train, d)];
		X_cv_d=[ones(m_cv,1) polynomialDegreeFeatures(X_cv, d)];
		%X_d=[X_d X_train.^d];
		%X_cv_d=[X_cv_d X_cv.^d];

		theta=normalEquation(X_d,y_train, 0);
		J=costFunction(theta, X_d, y_train);
		J_cv=costFunction(theta, X_cv_d, y_cv);
		
		if(J_cv<J_cv_temp)
			J_cv_temp=J_cv;
			d_min=d;
			theta_min=theta;
		end;

		d_vec(d)=d;
		J_vec(d)=J;
		J_cv_vec(d)=J_cv;
		
		fprintf('Diagnosing Bias vs. Variance d:%d J:%f J_cv:%f\n', d, J, J_cv);
	end

	plot(d_vec, J_vec, 'r');
	hold on;
	title('Bias vs. Variance');
	xlabel('NO. of polynome degree');
	ylabel('cost function J');
	plot(d_vec, J_cv_vec, 'b');
	legend('training','cross validation');
	hold off;
end
