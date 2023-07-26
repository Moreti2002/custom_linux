#!/usr/bin/env python3
import subprocess
import json

def get_workspaces():
    swaymsg = subprocess.Popen(['swaymsg', '-t', 'get_workspaces'], stdout=subprocess.PIPE)
    output, _ = swaymsg.communicate()
    return json.loads(output)

def select_workspace(workspaces):
    workspace_names = [ws['name'] for ws in workspaces]
    rofi_input = '\n'.join(workspace_names)

    rofi = subprocess.Popen(['rofi', '-dmenu', '-i', '-p', 'Switch to workspace:'],
                            stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                            text=True, encoding='utf-8')
    chosen_workspace, _ = rofi.communicate(input=rofi_input)
    return chosen_workspace.strip()

def switch_workspace(chosen_workspace):
    if chosen_workspace:
        subprocess.run(['swaymsg', f'workspace {chosen_workspace}'])

if __name__ == '__main__':
    workspaces = get_workspaces()
    chosen_workspace = select_workspace(workspaces)
    switch_workspace(chosen_workspace)

