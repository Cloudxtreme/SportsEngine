% rank()
%
function rank

	% Register global variables
	global cfb_initialized
	global skunk_initialized
	global sports_engine_path
	global module_path
	global application_path
	global skunkworks_model

	% Set environment
	addpath('../../Shared/');
	if ~skunk_initialized || ~cfb_initialized
		setEnvironment();
		if strcmp(module_path, '') || strcmp(application_path, '')
			fprintf('==========\n');
			fprintf('FILE: CFB/SkunkWorks/rank.m\n');
			fprintf('ERROR: Failed to fully set the environment\n');
			fprintf('==========\n\n');
			return
		end
	end

	% Check for model
	if ~exist(skunkworks_model, 'var')
		fprintf('==========\n');
		fprintf('FILE: CFB/SkunkWorks/rank.m\n');
		fprintf('ERROR: No SVM model has been set\n');
		fprintf('==========\n\n');
		return
	end

end

