function diagnosingBiasVarianceManually(X_train, y_train)
	m=length(y_train);
    d=[1 2 3 4];

	X_1=[ones(m,1) X_train];
	X_2=[ones(m,1) polynomialAllDegreeFeatures(X_train, 2)];
	X_3=[ones(m,1) polynomialAllDegreeFeatures(X_train, 3)];
	X_4=[ones(m,1) polynomialAllDegreeFeatures(X_train, 4)];
	%X_5=[ones(m,1) polynomialAllDegreeFeatures(X_train, 5)];

    theta1=normalEquation(X_1,y_train, 0);
    theta2=normalEquation(X_2,y_train, 0);
    theta3=normalEquation(X_3,y_train, 0);
    theta4=normalEquation(X_4,y_train, 0);
    %theta5=normalEquation(X_5,y_train, 0);

    J1=costFunction(theta1, X_1, y_train);
    J2=costFunction(theta2, X_2, y_train);
    J3=costFunction(theta3, X_3, y_train);
    J4=costFunction(theta4, X_4, y_train);
    %J5=costFunction(theta5, X_5, y_train);
    J_train_vec=[J1 J2 J3 J4];
    J_train_vec

	plot(d, J_train_vec, 'r');
	hold on;
	title('Bias vs. Variance');
	xlabel('NO. of polynome degree');
	ylabel('cost function J');
	hold off;
end
