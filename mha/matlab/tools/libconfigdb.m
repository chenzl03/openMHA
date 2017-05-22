function sLib = libconfigdb()
% LIBCONFIGDB - function handle library
%
% Usage:
% libconfigdb()
%
% Help to function "fun" can be accessed by calling
% configdb.help.fun()
%

% This file was generated by "bake_mlib configdb".
% Do not edit! Edit sources configdb_*.m instead.
%
% Date: 22-May-2017 10:19:49
sLib = struct;
sLib.clientconfig_get = @configdb_clientconfig_get;
sLib.help.clientconfig_get = @help_clientconfig_get;
sLib.clientconfig_set = @configdb_clientconfig_set;
sLib.help.clientconfig_set = @help_clientconfig_set;
sLib.fit_audprof_get = @configdb_fit_audprof_get;
sLib.help.fit_audprof_get = @help_fit_audprof_get;
sLib.fit_audprof_set = @configdb_fit_audprof_set;
sLib.help.fit_audprof_set = @help_fit_audprof_set;
sLib.fit_get_all = @configdb_fit_get_all;
sLib.help.fit_get_all = @help_fit_get_all;
sLib.fit_get_current = @configdb_fit_get_current;
sLib.help.fit_get_current = @help_fit_get_current;
sLib.fit_preset_list = @configdb_fit_preset_list;
sLib.help.fit_preset_list = @help_fit_preset_list;
sLib.fit_preset_load = @configdb_fit_preset_load;
sLib.help.fit_preset_load = @help_fit_preset_load;
sLib.fit_preset_save = @configdb_fit_preset_save;
sLib.help.fit_preset_save = @help_fit_preset_save;
sLib.fit_set_all = @configdb_fit_set_all;
sLib.help.fit_set_all = @help_fit_set_all;
sLib.fit_set_current = @configdb_fit_set_current;
sLib.help.fit_set_current = @help_fit_set_current;
sLib.fit_upload_current = @configdb_fit_upload_current;
sLib.help.fit_upload_current = @help_fit_upload_current;
sLib.get_mhaconfig = @configdb_get_mhaconfig;
sLib.help.get_mhaconfig = @help_get_mhaconfig;
sLib.readfile = @configdb_readfile;
sLib.help.readfile = @help_readfile;
sLib.set_mhaconfig = @configdb_set_mhaconfig;
sLib.help.set_mhaconfig = @help_set_mhaconfig;
sLib.smap_get = @configdb_smap_get;
sLib.help.smap_get = @help_smap_get;
sLib.smap_rm = @configdb_smap_rm;
sLib.help.smap_rm = @help_smap_rm;
sLib.smap_set = @configdb_smap_set;
sLib.help.smap_set = @help_smap_set;
sLib.writefile = @configdb_writefile;
sLib.help.writefile = @help_writefile;
assignin('caller','configdb',sLib);


function [val,sClientID] = configdb_clientconfig_get( mha, varname, val )
  if nargin < 2
    val = [];
  end
  sClientID = configdb_get_mhaconfig(mha,'client_id','');
  cCDB = configdb_get_mhaconfig(mha,'client_datab',cell([2,0]));
  sCData = configdb_smap_get(cCDB,sClientID);
  if ~isempty(sCData)
    try
      eval(sprintf('val=sCData.%s;',varname));
    catch
    end
  end


function help_clientconfig_get
disp([' CLIENTCONFIG_GET - ',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  [val,sClientID] = configdb.clientconfig_get( mha, varname, val );',char(10),'']);


function [val,sClientID] = configdb_clientconfig_set( mha, varname, val )
  sClientID = configdb_get_mhaconfig(mha,'client_id');
  cCDB = configdb_get_mhaconfig(mha,'client_datab',cell([2,0]));
  sCData = configdb_smap_get(cCDB,sClientID);
  if isempty(sCData)
    sCData = struct;
  end
  eval(sprintf('sCData.%s=val;',varname));
  cCDB = configdb_smap_set(cCDB,sClientID,sCData);
  configdb_set_mhaconfig(mha,'client_datab',cCDB);
  

function help_clientconfig_set
disp([' CLIENTCONFIG_SET - ',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  [val,sClientID] = configdb.clientconfig_set( mha, varname, val );',char(10),'']);


function sAud = configdb_fit_audprof_get( mha )
  sAud = configdb_get_mhaconfig(mha,'client_aud',[]);


function help_fit_audprof_get
disp([' FIT_AUDPROF_GET - ',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  sAud = configdb.fit_audprof_get( mha );',char(10),'']);


function configdb_fit_audprof_set( mha, sAud )
  configdb_set_mhaconfig(mha,'client_id',sAud.client_id);
  configdb_set_mhaconfig(mha,'client_aud',sAud);
  selected_auds = ...
      configdb_get_mhaconfig(mha,'client_aud_ids',cell([2,0]));
  selected_auds = ...
      configdb_smap_set(selected_auds,sAud.client_id,sAud.id);
  configdb_set_mhaconfig(mha,'client_aud_ids',selected_auds);


function help_fit_audprof_set
disp([' FIT_AUDPROF_SET - ',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  configdb.fit_audprof_set( mha, sAud );',char(10),'']);


function csPlugs = configdb_fit_get_all( mha )
  csPlugs = configdb_get_mhaconfig(mha,'all_compressors',[]);


function help_fit_get_all
disp([' FIT_GET_ALL - ',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  csPlugs = configdb.fit_get_all( mha );',char(10),'']);


function [sPlug,sClientID,sAud,sRule,sSide] = configdb_fit_get_current( mha )
  libaudprof();
  sPlug = configdb_get_mhaconfig( mha, 'current_compressor' );
  sAud = configdb_get_mhaconfig( mha, 'client_aud' );
  [sRule,sClientID] = configdb_clientconfig_get( mha, 'gain_rule','nogain' );
  sSide = configdb_get_mhaconfig( mha, 'next_fit_side','' );
  sAud.client_id = sClientID;
  sAud = audprof.audprof_cleanup( sAud );


function help_fit_get_current
disp([' FIT_GET_CURRENT - ',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  [sPlug,sClientID,sAud,sRule,sSide] = configdb.fit_get_current( mha );',char(10),'']);


function [csList,sCur,Idx] = configdb_fit_preset_list( mha )
  libmultifit();
  try
    sPlug = configdb_fit_get_current(mha);
    csPresets = configdb_clientconfig_get( mha,[sPlug.addr,'.presets'],cell([2 0]));
    vValidPresets = multifit.validate_fits(csPresets(2,:),sPlug,mha);
    idx_invalid = any(1-vValidPresets);
    csPresets(:,idx_invalid) = [];
    csList = csPresets(1,:);
    sCur = configdb_clientconfig_get( mha,[sPlug.addr,'.current_preset'],'');
    if isempty(sCur) && ~isempty(csList)
      sCur = csList{1};
    end
    Idx = strmatch(sCur,csList,'exact');
    if isempty(Idx)
      idx = 1;
    end
  catch
    disp_err_rethrow;
  end


function help_fit_preset_list
disp([' FIT_PRESET_LIST - ',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  [csList,sCur,Idx] = configdb.fit_preset_list( mha );',char(10),'']);


function configdb_fit_preset_load( mha, name )
  sPlug = configdb_get_mhaconfig(mha,'current_compressor');
  csPresets = configdb_clientconfig_get(mha,[sPlug.addr,'.presets'],cell([2 0]));
  idx = strmatch(name,csPresets(1,:),'exact');
  if isempty(idx)
    warndlg(['No preset ''',name,''' in preset list.']);
    return;
  end
  sPlug = csPresets{2,idx(1)};
  configdb_set_mhaconfig(mha,'current_compressor',sPlug);
  configdb_fit_upload_current( mha );
  configdb_clientconfig_set(mha,[sPlug.addr,'.current_preset'],name);


function help_fit_preset_load
disp([' FIT_PRESET_LOAD - ',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  configdb.fit_preset_load( mha, name );',char(10),'']);


function configdb_fit_preset_save( mha, name )
  sPlug = configdb_get_mhaconfig(mha,'current_compressor');
  csPresets = ...
      configdb_clientconfig_get(mha,[sPlug.addr,'.presets'],cell([2 0]));
  idx = strmatch(name,csPresets(1,:),'exact');
  if isempty(idx)
    csPresets(:,end+1) = {name;sPlug};
  else
    csPresets(:,idx(1)) = {name;sPlug};
  end
  configdb_clientconfig_set(mha,[sPlug.addr,'.presets'],csPresets);
  configdb_clientconfig_set(mha,[sPlug.addr,'.current_preset'],name);


function help_fit_preset_save
disp([' FIT_PRESET_SAVE - ',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  configdb.fit_preset_save( mha, name );',char(10),'']);


function configdb_fit_set_all( mha, csPlugs )
  configdb_set_mhaconfig(mha,'all_compressors',csPlugs);


function help_fit_set_all
disp([' FIT_SET_ALL - ',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  configdb.fit_set_all( mha, csPlugs );',char(10),'']);


function configdb_fit_set_current( mha, sPlug )
  configdb_set_mhaconfig(mha,'current_compressor',sPlug);


function help_fit_set_current
disp([' FIT_SET_CURRENT - ',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  configdb.fit_set_current( mha, sPlug );',char(10),'']);


function configdb_fit_upload_current(mha, sFT )
  sPlug = configdb_fit_get_current( mha );
  if nargin >= 2
    sPlug.finetuning = sFT;
  end
  if isfield(sPlug,'gaintable')
    libmultifit();
    sPlug.final_gaintable = ...
	multifit.upload(sPlug,mha);
  end
  configdb_fit_set_current(mha,sPlug);


function help_fit_upload_current
disp([' FIT_UPLOAD_CURRENT - ',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  configdb.fit_upload_current(mha, sFT );',char(10),'']);


function val = configdb_get_mhaconfig( mha, name, defval )
% Get a value from the Matlab configuration file linked to a given MHA
%
% mha      : Valid handle of a MHA
% name     : Variable name to store configuration.
% defval   : Data to be stored if no entry exists (of any Matlab type).
% val      : Data read from configuration.
%
% The variable name can refer to a member of a structure. In that
% case only the member is updated without overwriting the rest of
% the structure.
%
% Author: Giso Grimm
% Date: 2007
  ;
  if nargin < 3
    defval = [];
  end
  cfg = mha_get_basic_cfg_network( mha );
  defval = configdb_readfile('mha_ini.mat',name,defval);
  defval = configdb_readfile(cfg.ininame,name,defval);
  defval = configdb_readfile(cfg.ininame(1:end-2),name,defval);
  val = configdb_readfile(cfg.cfgname,name,defval);

function help_get_mhaconfig
disp([' GET_MHACONFIG - Get a value from the Matlab configuration file linked to a given MHA',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  val = configdb.get_mhaconfig( mha, name, defval );',char(10),'',char(10),'',char(10),' mha      : Valid handle of a MHA',char(10),' name     : Variable name to store configuration.',char(10),' defval   : Data to be stored if no entry exists (of any Matlab type).',char(10),' val      : Data read from configuration.',char(10),'',char(10),' The variable name can refer to a member of a structure. In that',char(10),' case only the member is updated without overwriting the rest of',char(10),' the structure.',char(10),'',char(10),' Author: Giso Grimm',char(10),' Date: 2007',char(10),'']);


function value = configdb_readfile( filename, varname, defvalue )
% read data from a configuration file
%
% filename : Name of configuration (Matlab) file.
% varname  : Variable name to store configuration.
% defvalue : Data to be stored if no entry exists (of any Matlab type).
% value    : Data read from configuration.
%
% The variable name can refer to a member of a structure. In that
% case only the member is updated without overwriting the rest of
% the structure.
%
% Author: Giso Grimm
% Date: 2007
  ;
  if nargin < 3
    defvalue = [];
  end
  [tpath,tname,tmext] = fileparts(filename);
  global get_config_file_cache;
  basename = varname;
  idx = strfind(basename,'.');
  if ~isempty(idx)
    basename(idx(1):end) = [];
  end
  data = struct;
  if exist(filename,'file')
    if strcmp(tmext,'.m')
      data = load_mscript( filename );
    else
      if ~isempty(get_config_file_cache) && ...
	    isfield(get_config_file_cache,tname)
	data = get_config_file_cache.(tname);
      else
	data = load(filename);
	get_config_file_cache.(tname) = data;
      end
    end
  end
  
  try
    eval(['value=data.',varname,';']);
  catch
    value = defvalue;
  end


function help_readfile
disp([' READFILE - read data from a configuration file',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  value = configdb.readfile( filename, varname, defvalue );',char(10),'',char(10),'',char(10),' filename : Name of configuration (Matlab) file.',char(10),' varname  : Variable name to store configuration.',char(10),' defvalue : Data to be stored if no entry exists (of any Matlab type).',char(10),' value    : Data read from configuration.',char(10),'',char(10),' The variable name can refer to a member of a structure. In that',char(10),' case only the member is updated without overwriting the rest of',char(10),' the structure.',char(10),'',char(10),' Author: Giso Grimm',char(10),' Date: 2007',char(10),'']);


function configdb_set_mhaconfig( mha, name, val )
% Set a value in the Matlab configuration file linked to a given MHA
%
% mha      : Valid handle of a MHA
% varname  : Variable name to store configuration.
% defvalue : Data to be stored (of any Matlab type).
%
% The variable name can refer to a member of a structure. In that
% case only the member is updated without overwriting the rest of
% the structure.
%
% Author: Giso Grimm
% Date: 2007
  ;
  cfg = mha_get_basic_cfg_network( mha );
  configdb_writefile(cfg.cfgname,name,val);

function help_set_mhaconfig
disp([' SET_MHACONFIG - Set a value in the Matlab configuration file linked to a given MHA',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  configdb.set_mhaconfig( mha, name, val );',char(10),'',char(10),'',char(10),' mha      : Valid handle of a MHA',char(10),' varname  : Variable name to store configuration.',char(10),' defvalue : Data to be stored (of any Matlab type).',char(10),'',char(10),' The variable name can refer to a member of a structure. In that',char(10),' case only the member is updated without overwriting the rest of',char(10),' the structure.',char(10),'',char(10),' Author: Giso Grimm',char(10),' Date: 2007',char(10),'']);


function [val, idx] = configdb_smap_get( cValues, sName, defval )
% Get an entry from a cell list and its index
  ;
  if nargin < 3
    defval = [];
  end
  idx = strmatch(sName,cValues(1,:),'exact');
  if isempty(idx)
    val = defval;
  else
    val = cValues{2,idx(1)};
  end

function help_smap_get
disp([' SMAP_GET - Get an entry from a cell list and its index',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  [val, idx] = configdb.smap_get( cValues, sName, defval );',char(10),'',char(10),'']);


function cValues = configdb_smap_rm( cValues, name )
% remove an entry from a cell list
%
% No error will be reported if name is not in list.
  ;
  [val,idx] = configdb_smap_get(cValues,name);
  if ~isempty(idx)
    cValues = [cValues(:,1:(idx(1)-1)),cValues(:,(idx(1)+1):end)];
  end

function help_smap_rm
disp([' SMAP_RM - remove an entry from a cell list',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  cValues = configdb.smap_rm( cValues, name );',char(10),'',char(10),'',char(10),' No error will be reported if name is not in list.',char(10),'']);


function cValues = configdb_smap_set( cValues, name, val )
% add an entry to a cell list
%
% Existing entries of the same name will be replaced.
  ; 
  [valt,idx] = configdb_smap_get(cValues,name);
  if isempty(idx)
    cValues(:,end+1) = {name;val};
  else
    cValues{2,idx} = val;
  end

function help_smap_set
disp([' SMAP_SET - add an entry to a cell list',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  cValues = configdb.smap_set( cValues, name, val );',char(10),'',char(10),'',char(10),' Existing entries of the same name will be replaced.',char(10),'']);


function configdb_writefile( filename, varname, value )
% store data in a configuration file
%
% filename : Name of configuration (Matlab) file.
% varname  : Variable name to store configuration.
% value    : Data to be stored (of any Matlab type).
%
% The variable name can refer to a member of a structure. In that
% case only the member is updated without overwriting the rest of
% the structure.
%
% Author: Giso Grimm
% Date: 2007
  ;
  basename = varname;
  idx = strfind(basename,'.');
  if ~isempty(idx)
    basename(idx(1):end) = [];
  end
  [tpath,tname,tmext] = fileparts(filename);
  global get_config_file_cache;
  if ~exist(filename,'file')
    data = struct;
  else
    if ~isempty(get_config_file_cache) && ...
	  isfield(get_config_file_cache,tname)
      data = get_config_file_cache.(tname);
    else
      data = load(filename);
    end
  end
  eval(sprintf('data.%s=value;',varname));
  get_config_file_cache.(tname) = data;
  if ~exist(filename,'file')
    save(filename,'-v7','-struct','data',basename);
  else
    warning('off','MATLAB:save:versionWithAppend')
    save(filename,'-v7','-append','-struct','data',basename);
    warning('on','MATLAB:save:versionWithAppend')
  end

function help_writefile
disp([' WRITEFILE - store data in a configuration file',char(10),'',char(10),' Usage:',char(10),'  configdb = libconfigdb();',char(10),'  configdb.writefile( filename, varname, value );',char(10),'',char(10),'',char(10),' filename : Name of configuration (Matlab) file.',char(10),' varname  : Variable name to store configuration.',char(10),' value    : Data to be stored (of any Matlab type).',char(10),'',char(10),' The variable name can refer to a member of a structure. In that',char(10),' case only the member is updated without overwriting the rest of',char(10),' the structure.',char(10),'',char(10),' Author: Giso Grimm',char(10),' Date: 2007',char(10),'']);


