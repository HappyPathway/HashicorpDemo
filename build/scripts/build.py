#!/usr/bin/env python2.7
import json
import subprocess
import shlex
import os
import sys

defaults = dict(color="blue", version="1.0.0", service_name="hashicorp", region="us-east-1")

def load_build_data():
    try:
        with open("deployment.json") as data_file:
            d = json.loads(data_file.read())
        build_data = d
    except:
        build_data = defaults
    return build_data


def set_packer(build_data):
    parent_directory = os.path.abspath(
        os.path.join(os.path.dirname(__file__), '..')
    )

    p = subprocess.Popen(
        "consul kv get config/global/ops_ami",
        shell=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )

    out, err = p.communicate()
    
    with open("{0}/app.json".format(parent_directory), "r") as packer_config:
        _p = json.loads(packer_config.read())
    
    _p["variables"]["source_ami"] = out.strip()
    _p["variables"]["region"] = build_data.get("region")

    with open("{0}/app.json".format(parent_directory), "w") as packer_config:
        packer_config.write(json.dumps(_p, separators=(',', ':'), indent=4))


def build_image(build_data):
    cmd = "packer build -var version={0} -var service_name={1} -var color={2} {3}/app.json"
    cmd = cmd.format(defaults.get("version"), 
                     defaults.get("service_name"), 
                     defaults.get("color"),
                     os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

    p = subprocess.Popen(shlex.split(cmd), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out, err = p.communicate()
    if p.returncode > 0:
        raise Exception("BuildImage:\nstdout:{0}\nstderr:{1}".format(str(out), str(err)))
    return out


def lookup_image(build_data):
    script_path = os.path.dirname(__file__)
    cmd = "{0}/ami_lookup.py --version={1} --service={2} --region={3}".format(
        script_path,
        build_data.get("version"),
        build_data.get("service_name"),
        build_data.get("region")
    )
    p = subprocess.Popen(
        shlex.split(cmd),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )
    out, err = p.communicate()
    if p.returncode > 0:
        raise Exception("LookupImage:\nstdout:{0}\nstderr:{1}".format(str(out), str(err)))
    return out
    
def set_image(build_data, ami):
    script_path = os.path.dirname(__file__)
    cmd = "{0}/set_ami.py --version={1} --service={2} --ami={3}".format(
        script_path,
        build_data.get("version"),
        build_data.get("service_name"),
        ami
    )
    p = subprocess.Popen(
        shlex.split(cmd),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )
    out, err = p.communicate()
    if p.returncode > 0:
        raise Exception("SetImage:\nstdout:{0}\nstderr:{1}".format(str(out), str(err)))
    return out

def main():
    build_data = load_build_data()
    print build_data
    set_packer(build_data)
    build_image(build_data)
    ami = lookup_image(build_data)
    set_image(build_data, ami)


if __name__ == '__main__':
    main()