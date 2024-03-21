configfile: "config.yaml"

import re
from chemwalker.gnps import Proteosafe

print('Retrieving GNPS result...')
gnps_result = Proteosafe(config["taskid"], config["workflow"])
gnps_result.get_gnps()
net = gnps_result.net
samples = net.ComponentIndex.unique()

config['kw'] = f'"ispositive": {config["ion_mode"]}, "adduct": "{config["adduct"]}", "ppm": {config["ppm"]}'
config['kw'] = re.sub("$", "}", re.sub("^", "{", config['kw']))

rule all:
    input:
        "nf_output/random_walk_output.tsv"

rule chemwalker:
    params:
        taskid = config["taskid"], workflow = config["workflow"], metfragpath = config["metfragpath"], savegraph = config["savegraph"], db = config["db"], kw = config["kw"]
    output:
        "nf_output/random_walk_output_{sample}.tsv"
    shell:
        "network_walk random-walk --taskid {params.taskid} --workflow {params.workflow} --comp {wildcards.sample}  --savegraph {params.savegraph} --db {params.db} --metfragpath {params.metfragpath} --kw '{params.kw}' --out {output}"

rule merger:
    input:
        expand("nf_output/random_walk_output_{sample}.tsv", sample=samples)
    output:
        "nf_output/random_walk_output.tsv"
    shell:
        "merge_conn_comp.py {input} {output}"
