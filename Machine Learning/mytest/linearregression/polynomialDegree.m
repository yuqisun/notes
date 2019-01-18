function degree = polynomialDegree(n, d)
    % n NO. of items in polynomial[NO. of boxes]
    % d max degree of polynomial[NO. of balls]
    % refer to question: d balls in n boxes [https://www.zhihu.com/question/51448931]

    degree=[];
    f(1, [], n, d);
    %[r,c]=size(degree);
    %fprintf('Total %d scenarios for %d items in polynomial and %d degree\n', r, n, d);

    function f(idx, row, boxes, balls)
      if(boxes==1)
        row(idx)=balls;
        degree=[degree;row];
        return;
      end

      for i=0:1:balls
        row(idx)=i;
        f(idx+1, row, boxes-1, balls-i);
      end
    end
end
