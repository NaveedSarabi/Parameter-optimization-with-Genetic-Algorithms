% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Copyright (C) 2014, by Emmanuel Dean (dean@tum.de)
% All rights reserved.
%
% This file is part of The Robot Modeler Toolbox for Matlab (RMTB).
%
% RMTB is free software: you can redistribute it and/or modify
% it under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% RMTB is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU Lesser General Public License for more details.
%
% You should have received a copy of the GNU Leser General Public License
% along with RTB.  If not, see <http://www.gnu.org/licenses/>.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.
%
% Neither the name of the Technische Universitaet Muenchen nor the names of
% its contributors may be used to endorse or promote products derived from
% this software without specific prior written permission.
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
function EraseCFHandles( handles )
%ERASECFCFHANDLES Deletes all the objects in the list of handles, except
%the figure handle and the main workspace handle
%   handles: list of object handles

sH=size(handles);


% In case the handles are arranged as row vector or column vector
if sH(1)>=sH(2)
    nHandles=sH(1);
else
    nHandles=sH(2);
end

for i=1:nHandles
    % if the handle exist and it is not root, nor figure, nor axes, then
    % delete it
    % find type
    %Firs check if is handle to avoid the problem of graph object
    if (ishandle(handles(i)))
        type=handles(i).Type;    
        if (~strcmp(type,'root'))&&(~strcmp(type,'figure'))&&(~strcmp(type,'axes'))
            %         fprintf(1,"(%d) Type %s Deleted!",i,type);
            delete(handles(i));
        end
    end
end

end

