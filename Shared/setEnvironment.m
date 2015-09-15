function setEnvironment
% setEnvironment()
%
% Handles paths and initialization for SportsEngine functions.
%
% If called from within a sport module (CFB, MCB, NFL), this will clear
% all current state, and initialize paths for that module in addition
% to the base SportsEngine platform.
%
% If called from within an application (SkunkWorks, DynamiteRankings),
% this will clear all current state, and initialize paths for that
% application in addition to the sport module and the base SportsEngine
% platform.
%
% Calling from a different module or application than the original
% environment, this will clear all current state and reinitialize for the
% new context.
%
% Global variables
%	sports_engine_initialized,
%	cfb_initialized,
%	mcb_initialized,
%	nfl_initialized,
%	skunk_initialized,
%	dynamite_initialized
% can be checked for true/false to determine if setEnvironment needs to be
% called.
%
% There is no harm in calling this more than is technically required, other
% than time.
%

	% Register global variables
	global sports_engine_initialized
	global cfb_initialized
	global mcb_initialized
	global nfl_initialized
	global skunk_initialized
	global dynamite_initialized
	global sports_engine_path
	global module_path

	% Reset environment
	sports_engine_initialized = false;
	cfb_initialized = false;
	mcb_initialized = false;
	nfl_initialized = false;
	sports_engine_path = '';
	restoredefaultpath();

	% Save root SportsEngine path
	curr_path = pwd();
	i_se = strfind(curr_path, 'SportsEngine');
	if ~isempty(i_se)
		sports_engine_path = curr_path(1:i_se+length('SportsEngine'));
		sports_engine_initialized = true;
	else
		fprintf('==========\n');
		fprintf('ERROR: Could not find SportsEngine root path in "%s"\n', curr_path);
		fprintf('==========\n\n');
		return
	end

	% Add this path for future reference
	addpath(sprintf('%sShared', sports_engine_path));

	% Determine current sport module
	i_cfb = strfind(curr_path, 'SportsEngine/CFB');
	i_mcb = strfind(curr_path, 'SportsEngine/MCB');
	i_nfl = strfind(curr_path, 'SportsEngine/NFL');
	if ~isempty(i_cfb)
		% Add paths
		module_path = sprintf('%sCFB/', sports_engine_path);
		addpath(sprintf('%sCFB/Core/', sports_engine_path));
		% Set initialization variables
		cfb_initialized = true;
		mcb_initialized = false;
		nfl_initialized = false;
	elseif ~isempty(i_mcb)
		% Add paths
		module_path = sprintf('%sMCB/', sports_engine_path);
		addpath(sprintf('%sMCB/Core/', sports_engine_path));
		% Set initialization variables
		cfb_initialized = true;
		mcb_initialized = true;
		nfl_initialized = false;
	elseif ~isempty(i_nfl)
		% Add paths
		module_path = sprintf('%sNFL/', sports_engine_path);
		addpath(sprintf('%NFL/Core/', sports_engine_path));
		% Set initialization variables
		cfb_initialized = true;
		mcb_initialized = false;
		nfl_initialized = true;
	else
		% Add paths
		module_path = '';
		% Clear initialization variables
		cfb_initialized = false;
		mcb_initialized = false;
		nfl_initialized = false;
	end

	% Determine application
	i_ss = strfind(curr_path, 'SkunkWorks');
	i_dr = strfind(curr_path, 'DynamiteRankings');
	if ~isempty(module_path)
		if ~isempty(i_ss)
			addpath(sprintf('%sSkunkWorks/', module_path));
			addpath(sprintf('%sSkunkWorks/Models/', module_path));
		elseif ~isempty(i_dr)
			addpath(sprintf('%DynamiteRankings/', module_path));
		end
	else
		if ~isempty(i_ss) || ~isempty(i_dr)
			fprintf('==========\n');
			fprintf('ERROR: You have an application folder outside of a sport module.\n');
			fprintf('		Please rename the folder to validate your file system.\n');
			fprintf('==========\n\n');
			fprintf()
		end
	end

	% Turn warnings off, or else be spammed by divide by zeros
	warning off

end
