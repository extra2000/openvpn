build_selinux_saltstack_minion_te_into_module:
  cmd.run:
    - name: checkmodule -M -m -o saltstack-minion.mod saltstack-minion.te
    - cwd: "{{ pillar['project_rootdir'] }}/provisions/selinux-policies"
    - runas: {{ pillar['username'] }}

build_saltstack_minion_te_module_into_pp_file:
  cmd.run:
    - name: semodule_package -o saltstack-minion.pp -m saltstack-minion.mod
    - cwd: "{{ pillar['project_rootdir'] }}/provisions/selinux-policies"
    - runas: {{ pillar['username'] }}
  
remove_existing_saltstack_minion_policy:
  cmd.run:
    - name: semodule -r saltstack-minion
    - success_retcodes:
      - "0"
      - "1"

load_saltstack_minion_pp_file:
  cmd.run:
    - name: semodule -i saltstack-minion.pp
    - cwd: "{{ pillar['project_rootdir'] }}/provisions/selinux-policies"
