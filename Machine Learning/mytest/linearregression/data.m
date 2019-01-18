data=load('data.txt')(1:1000,:);

[m,n]=size(data);
rand_idx=randperm(m);
rand_data=data(rand_idx, :);
X=rand_data(1:m, 1:n-1);

[X, mu, sigma] = featureNormalize(X);

y=rand_data(1:m, n);

m_train=floor(m*0.6);
X_train=X(1:m_train, :);
y_train=y(1:m_train, :);

m_cv=floor(m*0.2);
X_cv=X(m_train+1:m_train+m_cv, :);
y_cv=y(m_train+1:m_train+m_cv, :);

m_test=floor(m*0.2);
X_test=X(m_train+m_cv+1:m_train+m_cv+m_test, :);
y_test=y(m_train+m_cv+1:m_train+m_cv+m_test, :);

