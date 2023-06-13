xMax = 10;
yMax =  5;

%% Nested bars, do not accumulate
bst_progress('start', 'A bar', '', 0, 100) % Comment / Uncomment this line
for ix = 1 : xMax
    bst_progress('set', round(100 * ix/xMax))
    bst_progress('text', 'Running outside loop')
    pause(0.5)
    for iy = 1 : yMax        
        if iy == 1
            isProgressBar = bst_progress('isVisible');
            if ~isProgressBar
                bst_progress('start', 'Inside bar', '', 0, 100)
            end
        end
        bst_progress('text', 'Running inside loop')        
        bst_progress('set', round(100 * iy/yMax))  
    
        if ~isProgressBar && iy == yMax 
            bst_progress('stop')
        end
        pause(0.1)
    end
end
bst_progress('stop')

%% Nested bars, accumulate
bst_progress('start', 'A bar', '', 0, 100) % Comment / Uncomment this line
for ix = 1 : xMax
    bst_progress('set', round(100 * (ix-1)/xMax))
    bst_progress('text', 'Running outside loop')
    pause(0.5)
    for iy = 1 : yMax        
        if iy == 1
            isProgressBar = bst_progress('isVisible');
            if ~isProgressBar
                waitStart = 0;
                waitMax = 100;
                bst_progress('start', 'Inside bar', '', waitStart, 100)
            else
                waitStart = bst_progress('get');
                waitMax = round(100 * ix/xMax);
            end
        end
        bst_progress('text', 'Running inside loop')
        bst_progress('set', round(waitStart + iy/yMax * (waitMax - waitStart)))  
    
        if ~isProgressBar && iy == yMax 
            bst_progress('stop')
        end
        pause(0.1)
    end
end
bst_progress('stop')
