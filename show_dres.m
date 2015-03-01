% draw dres structure
function show_dres(frame_id, I, tit, dres)

cmap = colormap;
imshow(I);
title(tit);
hold on;

if isfield(dres, 'state') == 1
    index = find(dres.fr == frame_id & dres.state == 1);
else
    index = find(dres.fr == frame_id);
end

for i = 1:numel(index)
    ind = index(i);
    
    x = dres.x(ind);
    y = dres.y(ind);
    w = dres.w(ind);
    h = dres.h(ind);
    
    if isfield(dres, 'id') && dres.id(ind) > 0
        id = dres.id(ind);
        text(x, y, sprintf('%d', id), 'BackgroundColor',[.7 .9 .7]);
        index_color = min(1 + floor((id-1) * size(cmap,1) / max(dres.id)), size(cmap,1));
        c = cmap(index_color,:);
    else
        c = 'g';
    end
    if isfield(dres, 'occluded') && dres.occluded(ind) > 0
        s = '--';
    else
        s = '-';
    end
    rectangle('Position', [x y w h], 'EdgeColor', c, 'LineWidth', 2, 'LineStyle', s);
    
    if isfield(dres, 'id') && dres.id(ind) > 0
        % show the previous path
        ind = find(dres.id == id & dres.fr <= frame_id);
        centers = [dres.x(ind)+dres.w(ind)/2, dres.y(ind)+dres.h(ind)/2];
        plot(centers(:,1), centers(:,2), 'LineWidth', 2, 'Color', c);
    end
end
hold off;