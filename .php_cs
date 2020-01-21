<?php

$rules = [
    '@Symfony' => true,
    'array_syntax' => [
        'syntax' => 'short'
    ]
];

$excludes = [
    'cache',
    'views',
    'helpers/tcpdf',
    'libraries/old',
    'libraries/sdks'
];

return PhpCsFixer\Config::create()
    ->setRules($rules)
    ->setFinder(
        PhpCsFixer\Finder::create()
            ->in(__DIR__)
            ->exclude($excludes)
    );
