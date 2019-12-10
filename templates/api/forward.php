<?php

/**
 * Runs a furnace command
 * @param string $command
 * @return array|mixed
 */
function run($command = ''){
    $output = [];
    exec('sudo /usr/local/bin/furnace ' . $command, $output);
    return count($output) === 1 ? $output[0] : $output;
}

// Base settings
$app_token = run('api token');

// Passed data
$token = $_GET['token'];
$command = $_GET['cmd'];

if($token !== $app_token){
    die('Invalid token');
}

header('Content-type: application/json');
echo json_encode(run($command));
