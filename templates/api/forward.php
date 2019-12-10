<?php

function run($command = ''){
    $output = [];
    exec('sudo /usr/local/bin/furnace ' . $command, $output);
    return $output;
}

// Base settings
$app_token = run('api token')[0];

// Passed data
$token = $_GET['token'];
$command = $_GET['cmd'];

if($token !== $app_token){
    die('Invalid token');
}

header('Content-type: application/json');
echo json_encode(run($command));
