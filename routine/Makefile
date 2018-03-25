playbook_dir=operations
playbooks := $(wildcard $(playbook_dir)/*.yml)
tasks := $(notdir $(playbooks:.yml=))
.PHONY: help Makefile $(tasks) report

help:
	ls $(playbook_dir)

report: gather_specs

%: Makefile
	ansible-console $(playbook_dir)/$@
